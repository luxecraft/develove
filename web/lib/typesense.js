import TypesenseInstantsearchAdapter from "typesense-instantsearch-adapter";

const typesensePeople = new TypesenseInstantsearchAdapter({
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

const searchClientPeople = typesensePeople.searchClient;

export { searchClientPeople };

const typesensePosts = new TypesenseInstantsearchAdapter({
  server: {
    apiKey: "TPBbQ8qrVfkokxdno0Xt8GakbmH26Wkcjy15VhMPnK3jlNR4",
    nodes: [
      { host: "develove.ts.luxecraft.org", port: "443", protocol: "https" },
    ],
  },
  additionalSearchParameters: {
    queryBy: "title",
  },
});

const searchClientPosts = typesensePosts.searchClient;

export { searchClientPosts };
