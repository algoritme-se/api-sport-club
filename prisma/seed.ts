import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();


// create a seed function to create , Modalities,modalities_levels,plans,ClubUnit

async function main() {

  const modalities = [
    {
      name: 'FUTVOLEI',
      description: 'Futvolley is a sports ...',
    },
    {
      name: 'BEACHTENNIS',
      description: 'Beach tennis is a sport ...',
    },
    {
      name: 'BEACHVOLEI',
      description: 'Beach volleyball is a team sport ...'
    }]

  const modalities_levels = [
    {
      name: 'BEGINNER',
      description: 'Beginner level',
    },
    {
      name: 'INTERMEDIATE',
      description: 'Intermediate level',
    },
    {
      name: 'ADVANCED',
      description: 'Advanced level',
    },
  ]

  const plans = [
  {
    name: 'TRIAL',
    price: 0.00,
    description: 'Plano de aula experimental',
    allowed_modalities_number: 1, 
  },
    {
    name: 'PRATA',
    price: 170.00,
    description: 'Plano prata',
    allowed_modalities_number: 1,
  },
  {
    name: 'OURO',
    price: 250.00,
    description: 'Plano ouro',
    allowed_modalities_number: 2,
  },
  {
    name: 'DIAMANTE',
    price: 350.00,
    description: 'Plano diamante',
    allowed_modalities_number: 3,
  },
  {
    name: 'PLATINA',
    price: 450.00,
    description: 'Plano platina',
    allowed_modalities_number: 4,
  }]

  const club_units = [{
    name: 'Beach Sports Vertentes',
    address: 'Rua Jose Barreiros de Andrade, n: 96 - São Paulo - SP',
    description: 'SP',
    latitude: -23.593320,
    longitude: -46.745280,
  },
  {
    name: 'Beach Sports Butatã',
    address: 'Av. Vital Brasil, n: 305 - São Paulo - SP',
    description: 'SP',
    latitude: -23.5720127,
    longitude: -46.7099795,
  }]

  await prisma.modality.createMany({
    data: modalities
  })

  await prisma.modality_level.createMany({
    data: modalities_levels
  })

  await prisma.plan.createMany({
    data: plans
  })

  await prisma.clubUnit.createMany({
    data: club_units
  })

  await prisma.$disconnect();


}


main().catch((e) => {
  console.error(e);
  process.exit(1);
}).finally(async () => {
  await prisma.$disconnect();
});