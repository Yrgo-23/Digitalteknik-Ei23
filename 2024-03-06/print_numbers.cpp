/*******************************************************************************
 * @brief Template based implementation for printing signed and unsigned
 *        numbers of arbitrary size in C++.
******************************************************************************/
#include <bitset>
#include <cstdint>
#include <iostream>
#include <type_traits>

namespace bits
{
namespace 
{

/*******************************************************************************
 * @brief Provide the signed type that corresponds to specified unsigned type.
 * 
 * @tparam T The unsigned type whose signed equivalent is required.
 * 
 * @param Type The corresponding signed type.
 ******************************************************************************/
template <typename T>
struct Signed
{
    static_assert(std::is_unsigned<T>::value,
        "Struct bits::Signed only supports unsigned types!");
};

/*******************************************************************************
 * @brief Implementation of struct Signed.
 ******************************************************************************/
template <> struct Signed<std::uint8_t> { typedef std::int8_t Type; };
template <> struct Signed<std::uint16_t> { typedef std::int16_t Type; };
template <> struct Signed<std::uint32_t> { typedef std::int32_t Type; };
template <> struct Signed<std::uint64_t> { typedef std::int64_t Type; };

/*******************************************************************************
 * @brief Provide the size of specified type, measured in number of bits.
 * 
 * @tparam T The type whose size is required.
 * 
 * @return The number of bits of specified type.
 ******************************************************************************/
template <typename T>
constexpr std::size_t numBits() 
{ 
    static_assert(std::is_unsigned<T>::value,
        "bits::numBits only supports unsigned types!");
    return sizeof(T) * 8U; 
}

/*******************************************************************************
 * @brief Provide the two's complement of specified type.
 *
 * @tparam T Unsigned type whose two's complement is required.
 *
 * @return The required two's complement.
 ******************************************************************************/
 template <typename T>
 constexpr std::size_t get2Complement()
 {
     static_assert(std::is_unsigned<T>::value,
         "bits::get2Complement only supports unsigned types!");
     std::size_t complement{1U};
     for (std::size_t i{}; i < numBits<T>(); ++i) { complement *= 2U; }
     return complement;
 }

/*******************************************************************************
 * @brief Indicate if the MSB of specified value is set.
 *
 * @tparam T The type of the unsigned value to check.
 *
 * @param value The unsigned value to check.
 *
 * @return True if MSB is set, else false.
 ******************************************************************************/
 template <typename T>
 constexpr bool isMsbSet(const T value)
 {
     static_assert(std::is_unsigned<T>::value, 
         "bits::isMsbSet only supports unsigned types!");
     constexpr auto msbIndex{numBits<T>() - 1U};
     return value & (1UL << msbIndex);
 }

/*******************************************************************************
 * @brief Calculate the signed value equivalent to specified unsigned value.
 *
 * @tparam T The type of the unsigned value to cast (default = std::uint8_t).
 * 
 * @param value The unsigned value whose corresponding signed value is required.
 *
 * @return The equivalent signed value.
 ******************************************************************************/
template <typename T = std::uint8_t>
constexpr auto getSigned(const T value)
{
    static_assert(std::is_unsigned<T>::value, 
        "bits::getSigned supports casting from unsigned types only!");
    if (isMsbSet<T>(value)) { return static_cast<Signed<T>::Type>(value - get2Complement<T>()); }
    else { return static_cast<Signed<T>::Type>(value); }
}

/*******************************************************************************
 * @brief Print specified unsigned value and the equivalent signed value.
 *
 * @tparam T The type of the unsigned value to print (default = std::uint8_t).
 *
 * @param value The unsigned value to print.
 * @param ostream Reference to output stream (default = terminal print).
 ******************************************************************************/
template <typename T = std::uint8_t>
void print(const T value, std::ostream& ostream = std::cout)
{
    ostream << "--------------------------------------------------------------------------------\n";
    ostream << "Unsigned value:\t" << static_cast<std::uint64_t>(value) << "\n";
    ostream << "Signed value:\t" << static_cast<std::int64_t>(getSigned<T>(value)) << "\n";
    ostream << "Binary value:\t" << std::bitset<numBits<T>()>(value) << "\n\n";

    if (isMsbSet<T>(value))
    {
        ostream << "Since MSB = 1, the signed value is equal to " 
                << static_cast<std::uint64_t>(value) << " - " << get2Complement<T>() << " = "
                << static_cast<std::int64_t>(value - get2Complement<T>()) << "!\n";
    }
    else
    {
        ostream << "Since MSB = 0, the signed value is equal to the equivalent unsigned value!\n";
    }
    ostream << "--------------------------------------------------------------------------------\n";
}

} // namespace
} // namespace bits

/*******************************************************************************
 * @brief Print numbers 125 - 130 in signed and unsigned form.
 * 
 * @return Success code 0 upon termination of the program.
 ******************************************************************************/
int main()
{
    for (auto num{125U}; num <= 130U; ++num) 
    { 
        bits::print<std::uint8_t>(num); 
    }
    return 0;
}