import { FastifyRequest, FastifyReply } from 'fastify';
import { hash } from 'bcryptjs';
import { prisma } from '../../lib/prisma';
import { z } from 'zod';
import { registerUseCase } from '../../use-cases/register';
import { Prisma } from '@prisma/client';


export async function register(request: FastifyRequest, reply: FastifyReply) {


  const registerBodySchema = z.object({
    name: z.string(),
    email: z.string().email(),
    password: z.string().min(6),
    role: z.enum(['STUDENT', 'TEACHER', 'ADMIN'])
  });
  
  const { name, email, password } = registerBodySchema.parse(request.body);
  
  try {
    await registerUseCase({ name, email, password });
  } catch (error) {
    console.error(error);
    return reply.status(400).send({ message: error });
  }
  
  return reply.status(201).send({ message: 'User created successfully' });
  }