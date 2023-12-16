import { PrismaUserRepository } from '@/http/repositories/prisma/prisma-user-repository';
import { expect, describe, it } from 'vitest'
import { RegisterUseCase } from './register';
import { compare } from 'bcryptjs';
import { InMemoryUserRepository } from '@/http/repositories/in-memory-database/in-memory-user-repository';
import { UserAlreadyExistsError } from './errors/user-already-exists';

describe('User Register', () => {
  it('should be hashed the password in the database', async () => {

    // dependency injection of UserRepository
    const inMemoryUserRepository = new InMemoryUserRepository();
    const registerUseCase = new RegisterUseCase(inMemoryUserRepository);

    const { user } = await registerUseCase.execute({
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: '123456',
      role: 'STUDENT'
    })

    const isPasswordHashed = await compare('123456', user.password)

    expect(isPasswordHashed).toBe(true)
  })

  it('should not allow users to register with the same email address', async () => {
    // dependency injection of UserRepository
    const inMemoryUserRepository = new InMemoryUserRepository();
    const registerUseCase = new RegisterUseCase(inMemoryUserRepository);

    await registerUseCase.execute({
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: '123456',
      role: 'STUDENT'
    })

    expect(async () => {
      const response = await registerUseCase.execute({
        name: 'Daniel Silva',
        email: 'danielsilva@example.com',
        password: '123456',
        role: 'STUDENT'
      })

      return response
    }).rejects.toBeInstanceOf(UserAlreadyExistsError)
  })

  it('user must register and have use_status equal to TRIAL', async () => {

    // dependency injection of UserRepository
    const inMemoryUserRepository = new InMemoryUserRepository();
    const registerUseCase = new RegisterUseCase(inMemoryUserRepository);

    const { user } = await registerUseCase.execute({
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: '123456',
      role: 'STUDENT'
    })

    expect(user.user_status).toBe('TRIAL')
  })
})