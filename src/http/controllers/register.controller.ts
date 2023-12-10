import { FastifyRequest, FastifyReply } from 'fastify';
import { hash } from 'bcryptjs';
import { prisma } from '../../lib/prisma';
import { z } from 'zod';
import { registerUseCase } from '../../use-cases/register';


export async function register(request: FastifyRequest, reply: FastifyReply) {

  const registerBodySchema = z.object({
    name: z.string(),
    email: z.string().email(),
    password: z.string().min(6),
    modality: z.string(),
  });

  const { name, email, password, modality } = registerBodySchema.parse(request.body)

  try {
    await registerUseCase({ name, email, password, modality })
  } catch (error) {
    console.error(error);

    return reply.status(400).send({ message: error })
  }

  return reply.status(201).send({ message: 'User created successfully' })
}