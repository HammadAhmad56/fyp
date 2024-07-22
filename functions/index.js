const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.deleteUser = functions.https.onCall(async (data, context) => {
  const emailOrUid = data.emailOrUid;
  console.log(`Received request to delete user: ${emailOrUid}`);

  try {
    let user;
    if (emailOrUid.includes("@")) {
      console.log(`Looking up user by email: ${emailOrUid}`);
      user = await admin.auth().getUserByEmail(emailOrUid);
    } else {
      console.log(`Looking up user by UID: ${emailOrUid}`);
      user = await admin.auth().getUser(emailOrUid);
    }

    if (!user) {
      console.log(`User not found: ${emailOrUid}`);
      return { success: false, error: 'User not found' };
    }

    console.log(`User found: ${user.uid}, deleting user`);
    await admin.auth().deleteUser(user.uid);
    console.log(`User deleted: ${user.uid}`);

    return { success: true };
  } catch (error) {
    console.error(`Error deleting user: ${emailOrUid}`, error);
    if (error.code === 'auth/user-not-found') {
      return { success: false, error: 'User not found' };
    }
    return { success: false, error: error.message };
  }
});
