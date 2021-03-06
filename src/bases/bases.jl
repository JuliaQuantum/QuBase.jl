####################
# Type Definitions #
####################
    abstract AbstractBasis{S<:AbstractStructure} <: AbstractQuantum{S}
    abstract AbstractFiniteBasis{S<:AbstractStructure} <: AbstractBasis{S}
    abstract AbstractInfiniteBasis{S<:AbstractStructure} <: AbstractBasis{S}

#############
# Functions #
#############
    # Note: All B<:AbstractBasis types should implement the following: 
    #
    # checkcoeffs(coeffs, dim, basis::B) -> checks whether a coefficient
    #                                       array is valid for use with 
    #                                       the given basis. This is used 
    #                                       by QuArray to ensure that the 
    #                                       coefficient array is not malformed 
    #                                       with respect to the input bases. 
    #                                       The second argument, `dim`, specifies 
    #                                       the dimension of the coefficient 
    #                                       array which corresponds to the provided 
    #                                       basis.
    #
    # nfactors(basis::B) -> the number of factor bases for `basis`
    #
    # tensor(a::B, b::B) -> Take the tensor product of these two bases. This
    #                       function should optimally return a basis of same 
    #                       type as the input bases. We can and should also 
    #                       implement promote_rules/conversion methods between
    #                       bases.
    #
    # structure{S}(::Type{MyBasisType{S}}) -> returns S<:AbstractStructure for 
    #                                         the provided basis type.

    checkcoeffs(coeffs, dim, basis::AbstractBasis) = error("checkcoeffs(coeffs, dim, ::$(typeof(basis))) must be defined!")

    for basis=(:AbstractBasis, :AbstractFiniteBasis, :AbstractInfiniteBasis)
        @eval begin
            structure{S}(::Type{($basis){S}}) = S
        end
    end

######################
# Include Statements #
######################
    include("finitebasis.jl")
    include("labelbasis.jl")

export AbstractBasis,
    AbstractFiniteBasis,
    AbstractInfiniteBasis,
    checkcoeffs,
    structure


