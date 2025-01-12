// a crappy dear_binding -> odin generator
const file = await Bun.file('glfw/impl_glfw.json').json()

const keywords =['asm','auto_cast','bit_set','break','case','cast','context','continue',
	'defer','distinct','do','dynamic','else','enum','fallthrough','for','foreign','if',
	'import','in','map','not_in','or_else','or_return','package','proc','return','struct',
	'switch','transmute','typeid','union','using','when','where'];
const namespace = {} // [c-name]: odin-name

console.log(`package imgui\n
foreign import imgui "!!!!!!!!!!!!!"
`)

for (const en of file.enums) {
	let name = en.name;
	if (name.startsWith('ImGui'))
		name = name.substring(5)
	if (name.endsWith('_'))
		name = name.substring(0, name.length - 1)

	let out = `${name} :: enum {`
	for (const el of en.elements) {
		let el_name = el.name
		if (el_name.startsWith(en.name)) el_name = el_name.substring(en.name.length)
		if (el_name.startsWith('_')) el_name = el_name.substring(1)
		if (el_name.match(/^\d/)) el_name = 'Num' + el_name
		out += `\n\t${el_name}`;
		if (el.value !== undefined) {
			let v = el.value
			// if (el.value_expression.startsWith(en.name)) ve = el_name.substring(en.name.length)
			out += ` = ${v}`
		}
		out += ','
	}
	out += '\n}'
	console.log(out)
	if (en.name.endsWith('_')) namespace[en.name.substring(0, en.name.length - 1)] = name
	else namespace[en.name] = name
}

// see odin core:c
const cToOdinTypes = {
	'int': 'i32',
	'signed char': 'i8',
	'unsigned char': 'u8',
	'short': 'i16',
	'signed short': 'i16',
	'unsigned short': 'u16',
	'signed int': 'i32',
	'unsigned int': 'u32',
	'long long': 'i64',
	'signed long long': 'i64',
	'unsigned long long': 'u64',
	'void*': 'rawptr',
	'const void*': 'rawptr',
	'size_t': 'u32',
	'ssize_t': 'i32',
	'const char*': 'cstring',
	'char*': 'cstring',
	'unsigned char*': 'cstring',
	'bool': 'b8',
	'float': 'f32',
	'double': 'f64',
}

const fp_typedef = []
for (const td of file.typedefs) {
	if (namespace[td.name]) continue
	let name = td.name;
	if (name.startsWith('ImGui'))
		name = name.substring(5)

	let decl = td.type.declaration;
	if (decl in cToOdinTypes)
		decl = cToOdinTypes[decl];

	if (td.type.type_details?.flavour === 'function_pointer') {
		const fp_return_type = td.type.type_details.return_type.declaration
		const args = []
		for (const arg of td.type.type_details.arguments) {
			let type = '';
			if (arg.type.declaration in cToOdinTypes)
				type = cToOdinTypes[arg.type.declaration]
			else {
				let innerType = arg.type.description
				while (innerType.kind === 'Pointer') {
					type += '^'
					innerType = innerType.inner_type
				}
				if (innerType.name in namespace)
					type += namespace[innerType.name]
				else
				{
					type += innerType.name
				}
			}
			// args.push(`${arg.name}: ${type}`)
			args.push({
				name: arg.name,
				type: type,
			})
		}

		let return_type = null
		if (fp_return_type !== 'void'){
			if (fp_return_type in cToOdinTypes)
				return_type = cToOdinTypes[fp_return_type]
			else {
				let innerType = td.type.type_details.return_type
				while (innerType.kind === 'Pointer') {
					return_type += '^'
					innerType = innerType.inner_type
				}
				// return_type += innerType.name
			}
		}
		fp_typedef.push({
			name: name,
			args: args,
			return_type: return_type,
		})

	} else {
		console.log(`${name} :: ${decl}`)
	}
	namespace[td.name] = name
}


for (const fptd of fp_typedef) {
	let sep = ''
	let out = fptd.name
	out += ` :: proc(`
	for (const arg of fptd.args) {
		let type = arg.type
		if (arg.type in namespace) type = namespace[arg.type]
		out += `${sep}${arg.name}: ${type}`
		sep = ', '
	}
	out += `)`
	if (fptd.return_type !== null) out += ` -> ${fptd.return_type}`
	console.log(out)
}

console.log(`@(default_calling_convention = "cdecl", link_prefix = "ImGui_")
foreign imgui {`)

for (const fn of file.functions) {
	let name = fn.name;
	if (name.startsWith('ImGui_')) name = name.substring(6)

	const args = []
	for (const arg of fn.arguments) {
		let type = '';
		let name = (keywords.includes(arg.name))? '_' + arg.name: arg.name
		if (arg.is_varargs){
			name = '#c_vararg ' + name
			type = '..any'
		}
		else {
			if (arg.type.declaration in cToOdinTypes)
				type = cToOdinTypes[arg.type.declaration]
			else if (arg.type.declaration in namespace) {
				if (namespace[arg.type.declaration].startsWith('ImGui'))
					type = namespace[arg.type.declaration].substring('ImGui'.length)
				else
					type = namespace[arg.type.declaration]

			}
			else {

				let innerType = arg.type.description
				if (arg.is_array) {
					type += `[${innerType.bounds ?? ''}]`
					innerType = innerType.inner_type
				}
				let ptr = 0
				let ptr_chr = '^'
				while (innerType.kind === 'Pointer') {
					ptr++
					innerType = innerType.inner_type
				}
				if (ptr && innerType.builtin_type == 'void' || innerType.builtin_type?.endsWith('char'))  { 
					ptr-- 
					ptr_chr = '[^]'
				}
				for (let i = 0; i < ptr; i++) {
					type += ptr_chr
				}

				if (ptr_chr === '[^]') {
					if (innerType.builtin_type == 'void') type += 'rawptr'
					else if (innerType.builtin_type.endsWith('char')) type += 'cstring'
				}
				else if (innerType.name in namespace) type += namespace[innerType.name]
				else if (innerType.name in cToOdinTypes) type += cToOdinTypes[innerType.name]
				else if (innerType.builtin_type in cToOdinTypes) type += cToOdinTypes[innerType.builtin_type]
				else if (innerType.builtin_type?.replace('_',' ') in cToOdinTypes) type += cToOdinTypes[innerType.builtin_type.replace('_',' ')]
				else if (innerType.name) {
					if (innerType.name.startsWith('ImGui'))
						type += innerType.name.substring('ImGui'.length)
					else
						type += innerType.name
				}
				else type = '[!!!]'
			}
		}
		// args.push(`${arg.name}: ${type}`)
		args.push({
			name: name, // do a keyword check instead
			type: type,
		})
	}

	let sep = ''
	let out = name
	out += ` :: proc(`
	for (const arg of args) {
		let type = arg.type
		if (arg.type in namespace) type = namespace[arg.type]
		out += `${sep}${arg.name}: ${type}`
		sep = ', '
	}
	out += `)`

	if (fn.return_type.declaration !== 'void'){
		let return_type = ''
		if (fn.return_type in cToOdinTypes)
			return_type = cToOdinTypes[fp_return_type]
		else if (fn.return_type in namespace) {
			if (namespace[fn.return_type].startsWith('ImGui'))
			return_type = namespace[fn.return_type].substring('ImGui'.length)
		}
		else {
			let innerType = fn.return_type.description
			let ptr = 0
			let ptr_chr = '^'
			while (innerType.kind === 'Pointer') {
				ptr++
				innerType = innerType.inner_type
			}
			if (ptr && innerType.builtin_type == 'void' || innerType.builtin_type == 'char')  { 
				ptr-- 
				ptr_chr = '[^]'
			}
			for (let i = 0; i < ptr; i++) {
				return_type += ptr_chr
			}

			if (ptr_chr === '[^]') {
				if (innerType.builtin_type == 'void') return_type += 'rawptr'
				else if (innerType.builtin_type == 'char') return_type += 'cstring'
			}

			else if (innerType.name in namespace) {
				if (namespace[innerType.name].startsWith('ImGui'))
					return_type += namespace[innerType.name].substring('ImGui'.length)
				else
					return_type += namespace[innerType.name]
			} 
			else if (innerType.name in cToOdinTypes) return_type += cToOdinTypes[innerType.name]
			else if (innerType.builtin_type in cToOdinTypes) return_type += cToOdinTypes[innerType.builtin_type]
			else if (innerType.builtin_type?.replace('_',' ') in cToOdinTypes) return_type += cToOdinTypes[innerType.builtin_type.replace('_',' ')]
			else if (innerType.name) {
				if (innerType.name.startsWith('ImGui'))
					return_type += innerType.name.substring('ImGui'.length)
				else
					return_type += innerType.name
			} 
			else return_type = '[!!!]'
		}

		out += ` -> ${return_type}`
	}
	out += ` ---`
	console.log('\t'+out)
	namespace[fn.name] = name

}
console.log('}')

for (const struct of file.structs) {
	let name = struct.name;
	if (name.startsWith('ImGui'))
		name = name.substring(5)

	namespace[struct.name] = name

	let out = `${name} :: struct {\n`;
	for (const field of struct.fields) {
		out += '\t'
		out += field.name
		out += ': '
		let innerType = field.type.description
		if (field.is_array) {
			let bound = innerType.bounds
			// bleh
			if (innerType.bounds.startsWith('ImGui')) {
				bound = bound.substring('ImGui'.length)
				if (bound.split('_')[0] in namespace)
					bound = bound.split('_')[1]
				else
					bound = innerType.bounds
			}
			out += `[${bound ?? ''}]`
			innerType = innerType.inner_type
		}
		let ptr = 0
		let ptr_chr = '^'
		while (innerType.kind === 'Pointer') {
			ptr++
			innerType = innerType.inner_type
		}
		if (ptr && innerType.builtin_type == 'void' || innerType.builtin_type?.endsWith('char'))  { 
			ptr-- 
			ptr_chr = '[^]'
		}
		for (let i = 0; i < ptr; i++) {
			out += ptr_chr
		}
		if (ptr_chr === '[^]') {
			if (innerType.builtin_type == 'void') out += 'rawptr'
			else if (innerType.builtin_type.endsWith('char')) out += 'cstring'
		}
		else if (innerType.name in namespace) out += namespace[innerType.name]
		else if (innerType.name in cToOdinTypes) out += cToOdinTypes[innerType.name]
		else if (innerType.builtin_type in cToOdinTypes) out += cToOdinTypes[innerType.builtin_type]
		else if (innerType.builtin_type?.replace('_',' ') in cToOdinTypes) out += cToOdinTypes[innerType.builtin_type.replace('_',' ')]
		else if (innerType.name) {
			if (innerType.name.startsWith('ImGui'))
				out += innerType.name.substring('ImGui'.length)
			else
				out += innerType.name
		} 

		out += ',\n'
	}
	out += '}'
	console.log(out)
}


