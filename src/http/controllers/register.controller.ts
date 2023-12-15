import { FastifyRequest, FastifyReply } from 'fastify';
import { z } from 'zod';
import { RegisterUseCase } from '@/use-cases/register';
import { PrismaUserRepository } from '../repositories/prisma/prisma-user-repository';



export async function register(request: FastifyRequest, reply: FastifyReply) {

  const registerBodySchema = z.object({
    name: z.string(),
    email: z.string().email(),
    password: z.string().min(6),
    role: z.enum(['STUDENT', 'TEACHER', 'ADMIN'])
  });

  const { name, email, password } = registerBodySchema.parse(request.body);

  try {

    // dependency injection of PrismaUserRepository
    const prismaUserRepository = new PrismaUserRepository();
    const registerUseCase = new RegisterUseCase(prismaUserRepository);

    await registerUseCase.execute({ name, email, password });
  } catch (error) {
    console.error(error);
    return reply.status(400).send({ message: error });
  }

  return reply.status(201).send({ message: 'User created successfully' });
}