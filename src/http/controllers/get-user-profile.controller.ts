import { FastifyRequest, FastifyReply } from 'fastify';
import { z } from 'zod';
import { makeGetUserProfileCase } from '@/use-cases/factories/make-get-user-profile-case';
import { ResourceNotFoundError } from '@/use-cases/errors/resource-not-found';

export async function getUserProfile(request: FastifyRequest, reply: FastifyReply) {

  // Schema validation
  const userProfileParamSchema = z.object({
    userId: z.string().uuid(),
  });
  const { userId } = userProfileParamSchema.parse(request.params);

  try {

    // factory pattern using getUserProfileCase
    const authenticateUseCase = makeGetUserProfileCase();
    const user = await authenticateUseCase.execute({ userId });

    return reply.status(200).send(user);

  } catch (error) {

    if (error instanceof ResourceNotFoundError) {
      return reply.status(400).send({ message: error.message });
    }

    throw error;
  }

}