# Sport Club App (api)

Welcome to the Sports Club App, a powerful solution for modernizing the management of sports clubs.

## Key Features:

- Scheduler for Classes
Effortlessly plan and manage classes with a robust scheduling system. Set up recurring schedules, assign trainers, and notify participants for a streamlined training program.

- Event Announcements
Keep members engaged with instant event announcements. Broadcast upcoming tournaments, special training sessions, and social events to ensure everyone stays informed.

- Payment Management
Simplify financial transactions with an integrated payment management system. Easily track and manage student payments, ensuring a secure and seamless experience for administrators and members.

- Member Registration and Management
Facilitate easy member registration and centralize member profiles. Track attendance, monitor progress, and manage all club-related activities efficiently.


## Running this project:

### Using docker:

 ```console
  docker-compose up
 ```

### Using correct node js version:

```console

nvm use 18.16.0
node ci
npm run build
npm run start

```

### Execute database migrates and seeds:
 
```console
npm run migrate
npm run seed
```

## requirements analysis 

### RFS ( Functional Requirements )

- [x] It must be possible to register;
- [ ] It must be possible to authenticate;
- [ ] It must be possible to obtain a user's profile;
- [ ] It must be possible to obtain the number of check-ins carried out by the user in classes.
- [ ] It should be possible for the user to search for nearby units;
- [ ] It should be possible to schedule classes;
- [ ] It should be possible to check into a class.


### RNs ( Business rules )

- [x] The user must not be able to register with a duplicate email address.
- [x] All users receive TRIAL status when they register.
- [ ] The user must not perform more than 2 check-ins per day.
- [ ] The user can only view lessons within the time range of their plan ( see plan details )
- [ ] Trail status users can only make one appointment.

### RNFs
- [x] The user's password must be encrypted.
- [ ] The user must be identified with a JSON web token.