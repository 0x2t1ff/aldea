import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

export const checkQuickstrikes = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const now = admin.firestore.Timestamp.now();
    const query = db.collection('quickstrikes').where('fechaQuickstrike', '<=', now).where('finished', '==', false).where('isRandom', '==', true);
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
                const doc = snapshot.data();
                const docId = snapshot.id;
                await snapshot.ref.update({ 'active': true});
        
            });
            return null;
        });


