import { PrismaUserRepository } from "@/http/repositories/prisma/prisma-user-repository";
import { AuthenticateUseCase } from "../authenticate";

export function makeAuthenticateUseCase() {
  const usersRepository = new PrismaUserRepository();
  const authenticateUseCase = new AuthenticateUseCase(usersRepository);
  return authenticateUseCase;
}
