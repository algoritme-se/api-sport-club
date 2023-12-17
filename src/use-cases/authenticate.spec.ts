
import { expect, describe, it } from 'vitest'
import { hash } from 'bcryptjs';
import { InMemoryUserRepository } from '@/http/repositories/in-memory-database/in-memory-user-repository';
import { AuthenticateUseCase } from './authenticate';
import { InvalidCredentialsError } from './errors/invalid-credential';

describe('Authenticate Use Case', () => {
  it('should be able to authenticate', async () => {

    // dependency injection of UserRepository
    const usersRepository = new InMemoryUserRepository();
    // sut - system under test
    const sut = new AuthenticateUseCase(usersRepository);

    // create user
    await usersRepository.create({
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: await hash('123456', 6),
    })

    // user authentication
    const { user } = await sut.execute({
      email: 'danielsilva@example.com',
      password: '123456'

    })

    expect(user.id).toEqual(expect.any(String))
  })

  it('should not be able to authenticate with wrong email', async () => {

    const usersRepository = new InMemoryUserRepository();
    const sut = new AuthenticateUseCase(usersRepository);

    expect(async () => await sut.execute({
      email: 'danielsilva@example.com',
      password: '123456'

    })).rejects.toBeInstanceOf(InvalidCredentialsError)
  })

  it('should not be able to authenticate with wrong password', async () => {

    const usersRepository = new InMemoryUserRepository();
    const sut = new AuthenticateUseCase(usersRepository);

    // create user
    await usersRepository.create({
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: await hash('123456', 6),
    })

    expect(async () => await sut.execute({
      email: 'danielsilva@example.com',
      password: '101010'

    })).rejects.toBeInstanceOf(InvalidCredentialsError)

  })

})