import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
const cors = require('cors')({ origin: true });

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
            let docRef = await db.collectionGroup('pQuickstrikes').where('id', '==', docId).where('randomId', '>=', autoId).limit(1).get();
            if (docRef.docs.length === 0) {
                docRef = await db.collectionGroup('pQuickstrikes').where('id', '==', docId).where('randomId', '>=', '').limit(1).get();
            }
            const winner = docRef.docs[0].data()['user'];
            if (!winners.includes(winner)) {
                winners.push(winner);
            }
        }
        await snapshot.ref.update({ 'finished': true, 'winners': winners });

    });
    return null;
});

export const resetActivity = functions.pubsub.schedule('0 0 * * 0').onRun(async () => {
    const query = db.collection('activity').where('activity', '>', 0);
    const activities = await query.get();
    activities.forEach(async (snapshot) => {
        snapshot.ref.update({ 'activity': 0 });
    });
});

export const chatNotification = functions.database
    .ref('/messages/{chatroomId}/{messageId}').onCreate(
        async (snap) => {
            console.log('start of the chat notification');
            const messageData = snap.val();
            const message = messageData.message;
            const otherId = messageData.otherId;
            const name = messageData.username;
            await db.collection('users').doc(otherId).get().then(querySnapshot => {
                const docData = querySnapshot.data();
                if (docData !== undefined) {

                    const token = docData['pushToken'];
                    if (messageData['isImage'] === true) {
                        const payload = {
                            notification: {
                                title: `Tienes un mensaje de ${name}`,
                                body: 'Image',
                            }
                        };
                        admin
                            .messaging()
                            .sendToDevice(token, payload)
                            .then(response => {
                                console.log('Successfully sent message:', response);
                            })
                            .catch(error => {
                                console.log('Error sending message:', error);
                            });
                    } else {
                        console.log('isImage wasnt true');
                        console.log(docData['isImage']);
                        const payload = {

                            notification: {
                                title: `Tienes un mensaje de ${name}`,
                                body: message,
                            }
                        };
                        admin
                            .messaging()
                            .sendToDevice(token, payload)
                            .then(response => {
                                console.log('Successfully sent message:', response);
                            })
                            .catch(error => {
                                console.log('Error sending message:', error);
                            });
                    }

                }

            });
        });


export const banUser = functions.https.onRequest((request, response) => {
    response.set('Access-Control-Allow-Origin', '*');
    response.set('Access-Control-Allow-Methods', 'GET, PUT, POST, OPTIONS');
    response.set('Access-Control-Allow-Headers', '*');
    return cors(request, response, async () => {
        const { userId, communityId } = request.body;
        db.collection('communities').doc(communityId).get().then(community => {
            const data = community.data();
            if(data){
                let bannedUsers = data.bannedUsers as string[];
                if(bannedUsers){
                    bannedUsers.push(userId);
                    community.ref.update({'bannedUsers': bannedUsers});
                } else {
                    bannedUsers = [userId];
                }
            }
        }).catch(error => {
            console.log(`error al intentar obtener la comunidad al banear el user ${userId} de la comunidad ${communityId}`, error);
        });
    });
});

export const buttonQuickstrikes = functions.pubsub.schedule('* * * * *').onRun(async () => {
    const now = admin.firestore.Timestamp.now();
    const query = db.collection('quickstrikes').where('fechaQuickstrike', '<=', now).where('finished', '==', false).where('isGame', '==', true);
    const quickStrikes = await query.get();
    quickStrikes.forEach(async (snapshot) => {
        await snapshot.ref.update({ 'active': true });

    });
    return null;
});

export const questionQuickstrikes = functions.pubsub.schedule('* * * * *').onRun(async () => {
    const now = admin.firestore.Timestamp.now();
    const query = db.collection('quickstrikes').where('fechaQuickstrike', '<=', now).where('finished', '==', false).where('isQuestion', '==', true);
    const quickStrikes = await query.get();
    quickStrikes.forEach(async (snapshot) => {
        await snapshot.ref.update({ 'active': true });

    });
    return null;
});

export const finishedQuickstrike = functions.firestore.document('quickstrikes/{quickstrikeId}').onUpdate(async (snap) => {
    const quickstrikeId = snap.after.id;
    const query = db.collection('quickstrikes').doc(quickstrikeId);
    const quickstrike = await query.get();

    const quickstrikeData = quickstrike.data();
    if (quickstrikeData !== undefined) {
        if (quickstrikeData['winners'].length >= quickstrikeData['amount']) {
            const winnersList: any[] = [];

            quickstrikeData['winners'].forEach(async (element: string) => {
                const userPath = db.collection('users').doc(element);
                const userQuery = await userPath.get();
                const userData = userQuery.data();

                if (userData !== undefined) {
                    winnersList.push(userData['name']);
                    let wins = userData['winCount'];
                    wins++;
                    await userPath.update({ 'winCount': wins });
                    const token = userData['pushToken'];

                    const payload = {

                        notification: {
                            title: `Has ganado un quickstrike`,
                            body: quickstrikeData['title'],
                        }
                    };
                    admin
                        .messaging()
                        .sendToDevice(token, payload)
                        .then(response => {
                            console.log('Successfully sent message:', response);
                        })
                        .catch(error => {
                            console.log('Error sending message:', error);
                        });
                }
            });
            //TODO: update del avatarUrl una vez la creación de quickstrike pase ese dato
            const post = {
                'communityId': quickstrikeData['cid'],
                'communityName': quickstrikeData['communityName'],
                'fechaQuickstrike': quickstrikeData['fechaQuickstrike'],
                'amount': quickstrikeData['amount'],
                'description': quickstrikeData['description'],
                'imageUrl': quickstrikeData['imageUrl'],
                'isGame': quickstrikeData['isGame'],
                'isRandom': quickstrikeData['isRandom'],
                'isResult': true,
                'isAnnouncement': false,
                'modelo': quickstrikeData['modelo'],
                'title': quickstrikeData['title'],
                'winners': quickstrikeData['winners'],
                'likes': [],
                'avatarUrl': quickstrikeData['communityUrl'],
                'id': quickstrikeData['id'],
                //added the id variable to the post it does , needs testing on the comments of the new posts
            };

            db.collection('posts').add(post);
        }
    }
});


