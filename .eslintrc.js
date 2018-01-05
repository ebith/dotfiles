module.exports = {
  extends: ['xo', 'xo/esnext', 'xo/browser', 'plugin:unicorn/recommended'],
  plugins: ['unicorn'],
  rules: {
    indent: ['error', 2, {SwitchCase: 1}]
  }
};
