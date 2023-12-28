import { prisma } from '@/lib/prisma'
import { hash } from 'bcryptjs'
import { FastifyInstance } from 'fastify'
import request from 'supertest'

export async function createAndAuthenticateUser(
  app: FastifyInstance,
) {

  await prisma.user.create({
    data: {
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: await hash('123456', 6),
      role: 'STUDENT'
    },
  })


  const authResponse = await request(app.server).post('/sessions').send({
    email: 'danielsilva@example.com',
    password: '123456',
  })

  const { token } = authResponse.body

  return {
    token,
  }
}
