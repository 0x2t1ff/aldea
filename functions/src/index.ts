import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

export const checkQuickstrikes = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const now = admin.firestore.Timestamp.now();
    const query = db.collection('quickstrikes').where('feºchaQuickstrike', '<=', now).where('finished', '==', false).where('isRandom', '==', true);
    const quickStrikes = await query.get();
    quickStrikes.forEach(async (snapshot) => {
        const winners: any[] = [];
        const doc = snapshot.data();
        const docId = snapshot.id;
        let autoId: String = '';
        const chars =
            '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
        while (winners.length < doc['amount']) {
            while (autoId.length !== 28) {
                autoId += chars.charAt(Math.floor(Math.random() * chars.length));
            }
            let docRef = await db.collectionGroup('pQuickstrikes').where("id", "==", docId).where("randomId", ">=", autoId).limit(1).get();
            if (docRef.docs.length === 0) docRef = await db.collectionGroup('pQuickstrikes').where("id", "==", docId).where("randomId", ">=", "").limit(1).get();
            const winner = docRef.docs[0].data()['user'];
            if (!winners.includes(winner)) winners.push(winner);
        }
        await snapshot.ref.update({ 'finished': true, 'winners': winners });

    });
    return null;
});

export const chatNotification = functions.database
    .ref('/messages/{chatroomId}/{messageId}').onCreate(
        async (snap, context) => {
            console.log("start of the chat notification")
            const messageData = snap.val();
            const message = messageData.message;
            const otherId = messageData.otherId;
            await db.collection("users").doc(otherId).get().then(querySnapshot => {
                const docData = querySnapshot.data();
                if (docData !== undefined) {
                    const token = docData["pushToken"]
                    const payload = {
                        notification: {
                            title: `Tienes un mensaje de ${docData["name"]}`,
                            body: message,
                        }
                    }
                    admin
                        .messaging()
                        .sendToDevice(token, payload)
                        .then(response => {
                            console.log('Successfully sent message:', response)
                        })
                        .catch(error => {
                            console.log('Error sending message:', error)
                        })
                }

            })
        })


export const buttonQuickstrikes = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const now = admin.firestore.Timestamp.now();
    const query = db.collection('quickstrikes').where('fechaQuickstrike', '<=', now).where('finished', '==', false).where('isGame', '==', true);
    const quickStrikes = await query.get();
    quickStrikes.forEach(async (snapshot) => {
        await snapshot.ref.update({ 'active': true });

    });
    return null;
});

export const questionQuickstrikes = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const now = admin.firestore.Timestamp.now();
    const query = db.collection('quickstrikes').where('fechaQuickstrike', '<=', now).where('finished', '==', false).where('isQuestion', '==', true);
    const quickStrikes = await query.get();
    quickStrikes.forEach(async (snapshot) => {
        await snapshot.ref.update({ 'active': true });

    });
    return null;
});

export const finishedQuickstrike = functions.firestore.document("quickstrikes/{quickstrikeId}").onUpdate(async (snap, context,) => {
    const quickstrikeId = snap.after.id;
    const query = db.collection("quickstrikes").doc(quickstrikeId);
    const quickstrike = await query.get();
    const now = admin.firestore.Timestamp.now();
    const quickstrikeData = quickstrike.data();
    if (quickstrikeData !== undefined) {
        if (quickstrikeData['winners'].length >= quickstrikeData['amount']) {
            var winnersList: any[] = [];

            quickstrikeData["winners"].forEach(async (element: string) => {
                const userPath = db.collection("users").doc(element);
                const userQuery = await userPath.get();
                const userData = userQuery.data();
                if (userData !== undefined) {
                    winnersList.push(userData["name"])
                    var wins = userData["winCount"];
                    wins++;
                    await userPath.update({ "winCount": wins });

                }

            });
            //TODO: update del avatarUrl una vez la creación de quickstrike pase ese dato
            const post = {
                "communityId": quickstrikeData["cid"],
                "communityName": quickstrikeData["communityName"],
                "fechaQuickstrike": quickstrikeData["fechaQuickstrike"],
                "amount": quickstrikeData["amount"],
                "description": quickstrikeData["description"],
                "imageUrl": quickstrikeData["imageUrl"],
                "isGame": quickstrikeData["isGame"],
                "isRandom": quickstrikeData["isRandom"],
                "isResult": true,
                "isAnnouncement": false,
                "modelo": quickstrikeData["modelo"],
                "title": quickstrikeData["title"],
                "winners": winnersList,
                "likes": [],
                "avatarUrl": "placeholder",
            }

            const path = await db.collection("posts").add(post);
            const id = path.id;
            const followerRef = db.collection("followers").doc(quickstrikeData["cid"]);
            const follower = await followerRef.get();
            const followerData = follower.data();
            if (followerData !== undefined) {
                const posts = followerData["posts"];
                posts.push({ "date": now, "id": id });
                followerRef.update({ "posts": posts });
                const quickstrikes = followerData["quickstrikes"] as Array<[]>;
                quickstrikes.forEach((element: any) => {
                    if (quickstrikeId == element["id"]) {
                        quickstrikes.filter(x => x !== element);
                        followerRef.update({ "quickstrikes": quickstrikes });
                    }

                })
            }
        }


    }

})


