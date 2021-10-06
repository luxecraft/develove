module.exports = {
  purge: ["./pages/**/*.{js,ts,jsx,tsx}", "./components/**/*.{js,ts,jsx,tsx}"],
  darkMode: false, // or 'media' or 'class'
  theme: {
    colors: {
      transparent: "transparent",
      current: "currentColor",
      primary: {
        start: "#6ECD95",
        end: "#438F58",
        solid: "#59AF77",
      },
      secondary: {
        start: "#313131",
        end: "#282828",
        solid: "#2D2D2D",
      },
      white: "#FFFFFF",
      black: "#000000",
      accentGray: "#1F1F1F",
    },
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
