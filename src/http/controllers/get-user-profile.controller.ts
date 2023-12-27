import { FastifyRequest, FastifyReply } from 'fastify';
import { z } from 'zod';
import { makeGetUserProfileCase } from '@/use-cases/factories/make-get-user-profile-case';
import { ResourceNotFoundError } from '@/use-cases/errors/resource-not-found';

export async function getUserProfile(request: FastifyRequest, reply: FastifyReply) {

  const userId = request.user.sub;

  try {

    // factory pattern using getUserProfileCase
    const getUserProfile = makeGetUserProfileCase();
    const { user } = await getUserProfile.execute({ userId });

    return reply.status(200).send({
      user: {
        ...user,
        password: undefined,
      },
    });

  } catch (error) {

    if (error instanceof ResourceNotFoundError) {
      return reply.status(400).send({ message: error.message });
    }

    throw error;
  }

}