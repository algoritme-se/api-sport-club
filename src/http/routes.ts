import { FastifyInstance } from "fastify"
import { register } from "./controllers/register.controller"
import { prisma } from "@/lib/prisma"
import { authenticate } from "./controllers/authenticate.controller"
import { getUserProfile } from "./controllers/get-user-profile.controller"
import { jwtVerify } from "./middlewares/verify-jwt"


export async function appRoutes(app: FastifyInstance) {

  app.post('/users', register)

  app.post('/sessions', authenticate)

  app.get('/me', { onRequest: [jwtVerify] }, getUserProfile)

}
