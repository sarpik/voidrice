#!/usr/bin/env node
// .eslintrc.js

/**
eslint ~/.eslintrc.js --ignore-pattern '!.eslintrc.js' --fix
*/

/**
 * @sarpik eslint config,
 * available at https://github.com/sarpik/voidrice/blob/master/.eslintrc.js
 *
 * Supports TypeScript!
 * (
 *		https://javascriptplayground.com/typescript-eslint/
 *	&	https://www.robertcooper.me/using-eslint-and-prettier-in-a-typescript-project
 * )
 *
 */

module.exports = {
	extends: ["wesbos", "plugin:@typescript-eslint/recommended"],
	parser: "@typescript-eslint/parser" /** leggo typescript! */,
	plugins: ["@typescript-eslint"],
	rules: {
		"no-console": "off",
		quotes: [2, "double", { allowTemplateLiterals: true /** avoidEscape: dunno */ }],
		"prettier/prettier": [
			"error",
			{
				trailingComma: "es5",
				printWidth: 120,
				tabWidth: 4,
				useTabs: true,
				arrowParens: "always",
				breakBeforeElse: true,
				disableLanguages: [],
				flattenTernaries: true,
				proseWrap: "never",
				htmlWhitespaceSensitivity: "ignore",
			},
		],
	},
};
