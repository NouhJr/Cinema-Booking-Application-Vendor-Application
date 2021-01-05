const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.Function = functions.firestore.document('Vendor Notifications/{docID}').onCreate(
    (snapshot, context) => {
        return admin.messaging().sendToTopic('CustomerNotfication',
        {
            notification : {
                title : "New movies added !",
                body : "Vendor added new movie, view it now.",
                clickAction : 'FLUTTER_NOTIFICATION_CLICK'
            }
        }
        );
    }
);
