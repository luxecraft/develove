import * as functions from "firebase-functions";

const Users = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  functions.logger.debug(request.body, request.query);
  response.send("Hello from Firebase!");
});

export default Users;
