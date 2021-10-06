module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: ["eslint:recommended", "google"],
  rules: {
    quotes: ["error", "double"],
    "object-curly-spacing": "off",
    "quote-props": "off",
    indent: ["error", 2, { SwitchCase: 1 }],
  },
};
