const localStrategy = require('passport-local').Strategy;
const bcrypt = require('bcrypt');

function initialize(passport, getUserByEmail, getUserById) {
    const authenticateUser = async (email, password, done) => {
        const user = await getUserByEmail(email);
        if (user == null) {
            return done(null, false, { message: 'No user with that email'});
        }
        try {
            console.log(`password: ${password}`);
            console.log(`user: ${user['PasswordHash']}`);
            if(await bcrypt.compare(password, user['PasswordHash'])) {
                return done(null, user);
            } else {
                debug('password incorrect');
                return done(null, false, { message: 'Password incorrect' });
            }
        } catch (error) {
            return done(error);
        }
    }

    passport.use(new localStrategy({ usernameField: 'email'},
     authenticateUser));
    passport.serializeUser((user, done) => done(null, user));
    passport.deserializeUser( async (user, done) => {
        return done(null, await getUserById(user.userId))
    });
}

module.exports = initialize;