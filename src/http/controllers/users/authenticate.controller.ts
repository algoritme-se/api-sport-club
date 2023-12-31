import { FastifyRequest, FastifyReply } from 'fastify';
import { z } from 'zod';
import { InvalidCredentialsError } from '@/use-cases/errors/invalid-credential';
import { makeAuthenticateUseCase } from '@/use-cases/factories/make-authenticate-user-case';

export async function authenticate(request: FastifyRequest, reply: FastifyReply) {

  // Schema validation
  const authenticateBodySchema = z.object({
    email: z.string().email(),
    password: z.string().min(6),
  });
  const { email, password } = authenticateBodySchema.parse(request.body);

  try {

    // factory pattern using authenticateUseCase
    const authenticateUseCase = makeAuthenticateUseCase();
    const { user } = await authenticateUseCase.execute({ email, password });

    const token = await reply.jwtSign({}, { sign: { sub: user.id } });

    const refreshToken = await reply.jwtSign({}, { sign: { sub: user.id, expiresIn: '7d' } });

    return reply.setCookie('refreshToken', refreshToken, {
      path: '/',
      secure: true,
      sameSite: true,
      httpOnly: true,
    }).status(200).send({ token });

  } catch (error) {

    if (error instanceof InvalidCredentialsError) {
      return reply.status(400).send({ message: error.message });
    }

    throw error;
  }

}