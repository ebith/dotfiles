module.exports = {
  "globals": {
   // Firefox
   "Cu": true,
   "Cc": true,
   "Ci": true,
   "Services": true,
   "gBrowser": true,

   // Firefox Add-on
   "TreeStyleTabService": true,

   // Vimperator
   "Command": true,
   "__context__": true,
   "commandline": true,
   "commands": true,
   "io": true,
   "liberator": true,
   "modes": true,
   "plugins": true,
  },
  "rules": {
    // スタイル
    "space-unary-ops": 2,
    "space-return-throw-case": 2,
    "space-infix-ops": 2,
    "space-in-parens": [2, "never"],
    "space-before-function-paren": [2, { "anonymous": "always", "named": "never" }],
    "space-before-keywords": 2,
    "space-after-keywords": 2,
    "object-curly-spacing": [2, "never"],
    "no-trailing-spaces": 2,
    "no-spaced-func": 2,
    "key-spacing": [2, {"beforeColon": false, "afterColon": true}],
    "computed-property-spacing": [2, "never"],
    "comma-spacing": [2, {"before": false, "after": true}],
    "camelcase": 2,
    "block-spacing": 2,
    "array-bracket-spacing": 2,

    // ES6
    "prefer-template": 2,
    "prefer-spread": 2,
    "prefer-arrow-callback": 2,
    "object-shorthand": 2,
    "no-var": 2,
    "no-const-assign": 2,
    // "arrow-spacing": 2,
    "arrow-parens": [2, "always"],

    // 主なやつ
    "no-multi-spaces": 2,
    "consistent-return": 2,
    "eqeqeq": 2,
    "comma-dangle": 0,
    "no-unused-vars": [2, { "args": "none" }],
    "indent": [
      2,
      2
    ],
    "quotes": [
      2,
      "single"
    ],
    "linebreak-style": [
      2,
      "unix"
    ],
    "semi": [
      2,
      "always"
    ]
  },
  "env": {
    "es6": true,
    "browser": true
  },
  "extends": "eslint:recommended"
};
