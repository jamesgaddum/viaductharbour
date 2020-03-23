import * as functions from 'firebase-functions';
import * as admin from "firebase-admin";

admin.initializeApp();

export const createListener = functions.firestore
  .document('fl_content/{id}')
  .onCreate((change, context) => {
    const data = change.data() ?? {};
    const schema = data['_fl_meta_']['schema'];
    if (schema === 'notifications') {
      admin.messaging().send({
        notification: {
          title: data['title'],
          body: data['body']
        },
        data: {
          contentAvailable: 'true',
          click_action: 'FLUTTER_NOTIFICATION_CLICK',
          priority: 'high',
        },
        android: {
          priority: 'high',
        },
        topic: 'all',
      }).then(response => console.log(response))
      .catch(err => console.log(err));
    }
  });
