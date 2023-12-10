import { FastifyInstance } from "fastify"
import { register } from "./controllers/register.controller"
import { prisma } from "../lib/prisma"

export async function appRoutes(app: FastifyInstance) {
  
  app.post('/users', register)

  app.get('/users', async (request, reply) => {

    const users = await prisma.user.findMany({
      include: {
        student: true,
        teacher: true,
        admin: true,
      }
    })

    return reply.status(200).send(users)

  })
}
