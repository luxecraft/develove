import TypesenseInstantsearchAdapter from "typesense-instantsearch-adapter";

const typesense = new TypesenseInstantsearchAdapter({
  server: {
    apiKey: "TPBbQ8qrVfkokxdno0Xt8GakbmH26Wkcjy15VhMPnK3jlNR4",
    nodes: [
      { host: "develove.ts.luxecraft.org", port: "443", protocol: "https" },
    ],
  },
  additionalSearchParameters: {
    queryBy: "username, email, fullName",
  },
});

const searchClient = typesense.searchClient;

export default searchClient;
