-- CreateEnum
CREATE TYPE "AuthRole" AS ENUM ('STUDENT', 'TEACHER');

-- CreateTable
CREATE TABLE "authentication" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL,
    "twoFaKey" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "role" "AuthRole" NOT NULL,

    CONSTRAINT "authentication_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "students" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "documentNumber" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "photoUrl" TEXT,
    "email" TEXT NOT NULL,
    "modalityLevelId" INTEGER NOT NULL,
    "planId" INTEGER NOT NULL,
    "authUserid" INTEGER NOT NULL,

    CONSTRAINT "students_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "teachers" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "authUserid" INTEGER NOT NULL,

    CONSTRAINT "teachers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "modalities" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "modalities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "modality_levels" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "modality_levels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plans" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "description" TEXT NOT NULL,
    "allowedModalitiesNumber" INTEGER NOT NULL,

    CONSTRAINT "plans_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "club_units" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "club_units_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "classes" (
    "id" SERIAL NOT NULL,
    "modalityId" INTEGER NOT NULL,
    "teacherId" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "maximumStudents" INTEGER NOT NULL,
    "clubUnitId" INTEGER NOT NULL,
    "studentsBooked" INTEGER NOT NULL,

    CONSTRAINT "classes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "appointments" (
    "id" SERIAL NOT NULL,
    "studentId" INTEGER NOT NULL,
    "classId" INTEGER NOT NULL,
    "createAd" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "appointments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ModalityToStudent" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_ModalityToTeacher" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "authentication_email_key" ON "authentication"("email");

-- CreateIndex
CREATE UNIQUE INDEX "students_email_key" ON "students"("email");

-- CreateIndex
CREATE UNIQUE INDEX "students_authUserid_key" ON "students"("authUserid");

-- CreateIndex
CREATE UNIQUE INDEX "teachers_name_key" ON "teachers"("name");

-- CreateIndex
CREATE UNIQUE INDEX "teachers_authUserid_key" ON "teachers"("authUserid");

-- CreateIndex
CREATE UNIQUE INDEX "modalities_name_key" ON "modalities"("name");

-- CreateIndex
CREATE UNIQUE INDEX "modality_levels_name_key" ON "modality_levels"("name");

-- CreateIndex
CREATE UNIQUE INDEX "plans_name_key" ON "plans"("name");

-- CreateIndex
CREATE UNIQUE INDEX "club_units_name_key" ON "club_units"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_ModalityToStudent_AB_unique" ON "_ModalityToStudent"("A", "B");

-- CreateIndex
CREATE INDEX "_ModalityToStudent_B_index" ON "_ModalityToStudent"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_ModalityToTeacher_AB_unique" ON "_ModalityToTeacher"("A", "B");

-- CreateIndex
CREATE INDEX "_ModalityToTeacher_B_index" ON "_ModalityToTeacher"("B");

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_modalityLevelId_fkey" FOREIGN KEY ("modalityLevelId") REFERENCES "modality_levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_planId_fkey" FOREIGN KEY ("planId") REFERENCES "plans"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_authUserid_fkey" FOREIGN KEY ("authUserid") REFERENCES "authentication"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teachers" ADD CONSTRAINT "teachers_authUserid_fkey" FOREIGN KEY ("authUserid") REFERENCES "authentication"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes" ADD CONSTRAINT "classes_modalityId_fkey" FOREIGN KEY ("modalityId") REFERENCES "modalities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes" ADD CONSTRAINT "classes_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "teachers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes" ADD CONSTRAINT "classes_clubUnitId_fkey" FOREIGN KEY ("clubUnitId") REFERENCES "club_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_classId_fkey" FOREIGN KEY ("classId") REFERENCES "classes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ModalityToStudent" ADD CONSTRAINT "_ModalityToStudent_A_fkey" FOREIGN KEY ("A") REFERENCES "modalities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ModalityToStudent" ADD CONSTRAINT "_ModalityToStudent_B_fkey" FOREIGN KEY ("B") REFERENCES "students"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ModalityToTeacher" ADD CONSTRAINT "_ModalityToTeacher_A_fkey" FOREIGN KEY ("A") REFERENCES "modalities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ModalityToTeacher" ADD CONSTRAINT "_ModalityToTeacher_B_fkey" FOREIGN KEY ("B") REFERENCES "teachers"("id") ON DELETE CASCADE ON UPDATE CASCADE;
