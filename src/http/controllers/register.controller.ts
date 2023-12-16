import { FastifyRequest, FastifyReply } from 'fastify';
import { z } from 'zod';
import { RegisterUseCase } from '@/use-cases/register';
import { PrismaUserRepository } from '../repositories/prisma/prisma-user-repository';
import { UserAlreadyExistsError } from '@/use-cases/errors/user-already-exists';



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
    if (error instanceof UserAlreadyExistsError) {
      return reply.status(409).send({ message: error.message });
    }

    throw error;
  }

  return reply.status(201).send({ message: 'User created successfully' });
}