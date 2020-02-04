import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

export const createUserDoc = functions.region("europe-west1").auth.user().onCreate((user) =>
    db.collection("users").add({ email: user.email, photoUrl: user.photoURL, uid: user.uid, phoneNumber: user.phoneNumber})
);