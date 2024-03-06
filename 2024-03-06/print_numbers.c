/*******************************************************************************
 * @brief Implementation for printing signed and unsigned 8-bit numbers in C.
******************************************************************************/
#include <stdint.h>
#include <stdio.h>

/*******************************************************************************
 * @brief Print specified unsigned 8-bit value in binary form.
 *
 * @param value The unsigned value to print.
 * @param end   Ending characters to print, if any (else pass a nullptr).
 ******************************************************************************/
static void print_binary_u8(const uint8_t value, const char* const end)
{
    for (int i = 7U; i >= 0; --i)
    {
        if (value & (1U << i)) { printf("1"); }
        else { printf("0"); }
    }
    if (end != NULL) { printf("%s", end); }
}

/*******************************************************************************
 * @brief Print specified unsigned 8-bit value and the equivalent signed value.
 *
 * @param value The unsigned value to print.
 ******************************************************************************/
static void print_u8(const uint8_t value)
{
    printf("--------------------------------------------------------------------------------\n");
    printf("Unsigned value:\t%d\n", value);
    printf("Signed value:\t%d\n", (int8_t)(value));
    printf("Binary value:\t");
    print_binary_u8(value, "\n\n");

    if (value & (1U << 7U))
    {
        printf("Since MSB = 1, the signed value is equal to %d - 256 = %d!\n", value, value - 256);
    }
    else
    {
        printf("Since MSB = 0, the signed value is equal to the equivalent unsigned value!\n");
    }
    printf("--------------------------------------------------------------------------------\n\n");
}

/*******************************************************************************
 * @brief Print numbers 125 - 130 in signed and unsigned form.
 *
 * @return Success code 0 upon termination of the program.
 ******************************************************************************/
int main()
{
    for (uint8_t num = 125U; num <= 130U; ++num)
    {
        print_u8(num);
    }

    return 0;
}