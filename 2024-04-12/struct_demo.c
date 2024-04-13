/*******************************************************************************
 * @brief Demonstration of how to use structs in C.
 ******************************************************************************/
#include <stdio.h>

/*******************************************************************************
 * @brief Struct for holding person data.
 * 
 * @param name       The name of the person.
 * @param age        The age of the person.
 * @param profession The profession of the person.
 * @param experience The number of years of experience in the profession.
 ******************************************************************************/
struct person
{
    const char* name;
    unsigned int age;
    const char* profession;
    unsigned int experience;
};

/*******************************************************************************
 * @brief Prints person data in the terminal.
 * 
 * @param self Reference to struct holding person data.
 ******************************************************************************/
static void person_print(const struct person* self)
{
    printf("--------------------------------------------------------------------------------\n");
    printf("Name:\t\t%s\n", self->name);
    printf("Age:\t\t%u\n", self->age);
    printf("Profession:\t%s\n", self->profession);
    printf("Experience:\t%u years\n", self->experience);
    printf("--------------------------------------------------------------------------------\n");
}

/*******************************************************************************
 * @brief Creates two structs holding person data and generates terminal print.
 * 
 * @return Success code 0 after termination of the program.
 ******************************************************************************/
int main()
{
    struct person p1 = { "Mikael Eriksson", 57, "Software developer", 24 };
    struct person p2 = { "Sven Svensson", 63, "Chef", 36 };
    person_print(&p1);
    person_print(&p2);
    return 0;
}
