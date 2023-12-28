import { FastifyInstance } from "fastify"
import { register } from "./controllers/users/register.controller"
import { prisma } from "@/lib/prisma"
import { authenticate } from "./controllers/users/authenticate.controller"
import { getUserProfile } from "./controllers/users/get-user-profile.controller"
import { jwtVerify } from "./middlewares/verify-jwt"
import { refresh } from "./controllers/users/refresh.controller"


export async function appRoutes(app: FastifyInstance) {

  app.post('/users', register)

  app.post('/sessions', authenticate)

  app.patch('/token/refresh',refresh)

  app.get('/me', { onRequest: [jwtVerify] }, getUserProfile)

}
