import TypesenseInstantsearchAdapter from "typesense-instantsearch-adapter";

const typesense = new TypesenseInstantsearchAdapter({
  server: {
    apiKey: "YOUR_API_KEY",
    nodes: {
      host: "develove.ts.luxecraft.org",
      port: "443",
      protocol: "https",
    },
  },
  additionalSearchParameters: {
    queryBy: "username, title, email, fullName",
  },
});

const searchClient = typesense.searchClient;

export default searchClient;
