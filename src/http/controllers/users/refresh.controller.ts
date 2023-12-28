import { FastifyRequest, FastifyReply } from 'fastify';
import { InvalidCredentialsError } from '@/use-cases/errors/invalid-credential';


export async function refresh(request: FastifyRequest, reply: FastifyReply) {

  try {
    await request.jwtVerify({ onlyCookie: true })

    const userId = request.user.sub;
    const token = await reply.jwtSign({}, { sign: { sub: userId } });

    const refreshToken = await reply.jwtSign({}, { sign: { sub: userId, expiresIn: '7d' } });

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