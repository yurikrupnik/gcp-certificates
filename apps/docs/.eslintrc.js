module.exports = {
  parser: "@typescript-eslint/parser",
  plugins: ["solid", "@typescript-eslint"],
  extends: ["../../.eslintrc.json"],
  ignorePatterns: ["!**/*"],
  overrides: [
    {
      files: ["*.ts", "*.js", "*.tsx"],
      parserOptions: {
        project: ["apps/docs/tsconfig.*?.json"],
      },
      rules: {},
    },
    {
      files: ["*.ts", "*.tsx"],
      rules: {},
    },
    {
      files: ["*.js", "*.jsx"],
      rules: {},
    },
  ],
  settings: {
    "solid/typescript": require("typescript"),
  },
};
