
import { expect, describe, it, beforeEach } from 'vitest'
import { hash } from 'bcryptjs';
import { InMemoryUserRepository } from '@/http/repositories/in-memory-database/in-memory-user-repository';
import { GetUserProfileUseCase } from './get-user-profile';
import { ResourceNotFoundError } from './errors/resource-not-found';

let usersRepository: InMemoryUserRepository
let sut: GetUserProfileUseCase

describe('Get User Profile Use Case', () => {

  // execute before each test
  beforeEach(() => {
    usersRepository = new InMemoryUserRepository()
    sut = new GetUserProfileUseCase(usersRepository)
  })

  it('should be able to get user profile by id', async () => {

    // create user
    const { id } = await usersRepository.create({
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: await hash('123456', 6),
    })

    // user authentication
    const { user } = await sut.execute({
      userId: id
    })

    expect(user.name).toEqual('Daniel Silva')
  })

  it('should not be able to get user profile by an invalid id', async () => {

    expect(async () => await sut.execute({
      userId: 'invalid-id'
    })).rejects.toBeInstanceOf(ResourceNotFoundError)
  })


})