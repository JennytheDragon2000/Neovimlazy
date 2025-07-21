local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

ls.add_snippets("lua", {
	s("h", t("hello world")),
})

-- ls.add_snippets("lua", {
-- 	s("fu", t("function(values) vim.print(values) end, {1, 2}")),
-- })
--

-- ls.add_snippets("lua", {
-- 	s(
-- 		"fu",
-- 		fmt([[function(values)
--         vim.print(values)
--     end, {{1, 2}}
--     ]])
-- 	),
-- })
--

ls.add_snippets("lua", {
	s(
		"fu",
		fmt(
			[[
            function({})
                vim.print({})
            end
            ]],
			{ i(1, "values"), rep(1) }
		)
	),
})

ls.add_snippets("lua", {
	s("var", {
		t("local "),
		i(2),
		t(" = "),
		i(1),
	}),
})

ls.add_snippets("java", {
	s(
		"psvm",
		fmt(
			[[
        public static void main(String[] args) {{
            {}
        }}
    ]],
			{ i(1) }
		)
	),
})

ls.add_snippets("java", {
	s(
		"for",
		fmt(
			[[
        for (int {} = {}; {} < {}; {}++) {{
            {}
        }}
    ]],
			{
				i(1, "i"), -- Iterator variable (default: "i")
				i(2, "0"), -- Initial value (default: "0")
				rep(1), -- Reuse the iterator variable
				i(3, "n"), -- Condition (default: "n")
				rep(1), -- Reuse the iterator variable
				i(4, "// code"), -- Loop body (default: "// code")
			}
		)
	),
})

ls.add_snippets("java", {
	s(
		"fe",
		fmt(
			[[
        for ({} {} : {}) {{
            {}
        }}
    ]],
			{
				i(1, "Type"), -- Type of elements (e.g., "String")
				i(2, "element"), -- Element variable
				i(3, "collection"), -- Collection to iterate over
				i(4, "// code"), -- Loop body
			}
		)
	),
})

ls.add_snippets("java", {
	s("sout", fmt("System.out.println({});", { i(1, '""') })),
})

ls.add_snippets("java", {
	s(
		"c",
		fmt(
			[[
        class {} {{
            {}
        }}
    ]],
			{ i(1), i(2) }
		)
	),
})
