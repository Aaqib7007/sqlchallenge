-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "sodt-attributes" (
    "rater_id" INT   NOT NULL,
    "reference_title" VARCHAR(255)   NOT NULL,
    "soft_attribute" VARCHAR(255)   NOT NULL,
    "less_than" VARCHAR(255)   NOT NULL,
    "about_as" VARCHAR(255)   NOT NULL,
    "more_than" VARCHAR(255)   NOT NULL
);

