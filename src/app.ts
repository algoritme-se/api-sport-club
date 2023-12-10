import fastify, { FastifyRequest } from "fastify";
import { prisma } from "./lib/prisma";
import { z } from "zod";

export const app = fastify()

app.post('/users', async (request, reply) => {

  const registerBodySchema = z.object({
    name: z.string(),
    email: z.string().email(),
    password: z.string().min(6),
    modality: z.string(),
  });

  const { name, email, password, modality } = registerBodySchema.parse(request.body)

   await prisma.user.create({
    data: {
      name, 
      email,
      password,
      role: 'STUDENT',
      student: {
        create: {
          modality: { connect: { id: modality } },
          modality_level_id: '1894c606-29e4-4801-bd62-07eaf593a862',
          plan_id: '0e8629e6-4bb6-4296-a4ef-7a63ae354fec',
          status: 'TRIAL',
        }
      }
    }
  })

  return reply.status(201).send({ message: 'User created successfully' })

})

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