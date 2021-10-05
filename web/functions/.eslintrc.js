/* eslint-disable quote-props */
module.exports = {
  sourceType: "module",
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "plugin:import/typescript",
    "google",
  ],
  plugins: ["import"],
  rules: {
    quotes: ["error", "double"],
    "import/no-unresolved": 0,
  },
};
