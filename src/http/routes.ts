import { FastifyInstance } from "fastify"
import { register } from "./controllers/register.controller"
import { prisma } from "@/lib/prisma"
import { authenticate } from "./controllers/authenticate.controller"

export async function appRoutes(app: FastifyInstance) {
  
  app.post('/users', register)

  app.get('/users', async (request, reply) => {

    const users = await prisma.user.findMany()

    return reply.status(200).send(users)

  })

  app.post('/sessions',authenticate)
}
