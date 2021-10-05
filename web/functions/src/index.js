import * as functions from "firebase-functions";

export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", { structuredData: true });
  functions.logger.debug(request.body, request.query);
  response.send("Hello from Firebase!");
});
