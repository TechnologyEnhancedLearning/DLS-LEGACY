
Imports System.Globalization
Imports System.Security.Cryptography
Imports System.Text
Imports System.Web

Public NotInheritable Class Crypto
    Private Sub New()
    End Sub
    Private Const PBKDF2IterCount As Integer = 1000
    ' default for Rfc2898DeriveBytes
    Private Const PBKDF2SubkeyLength As Integer = 256 / 8
    ' 256 bits
    Private Const SaltSize As Integer = 128 / 8
    ' 128 bits
    Private Const TokenSize As Integer = 16

    '[SuppressMessage("Microsoft.Naming", "CA1720:IdentifiersShouldNotContainTypeNames", MessageId = "byte", Justification = "It really is a byte length")]
    Friend Shared Function GenerateSaltInternal(ByVal byteLength As Integer) As Byte()
        Dim buf As Byte() = New Byte(byteLength - 1) {}
        Dim rng = New RNGCryptoServiceProvider()

        rng.GetBytes(buf)

        Return buf
    End Function

    '[SuppressMessage("Microsoft.Naming", "CA1720:IdentifiersShouldNotContainTypeNames", MessageId = "byte", Justification = "It really is a byte length")]
    Public Shared Function GenerateSalt(ByVal byteLength As Integer) As String
        Return Convert.ToBase64String(GenerateSaltInternal(byteLength))
    End Function

    Public Shared Function Hash(ByVal input As String, ByVal algorithm As String) As String
        If input Is Nothing Then
            Throw New ArgumentNullException("input")
        End If

        Return Hash(Encoding.UTF8.GetBytes(input), algorithm)
    End Function

    Public Shared Function Hash(ByVal input As Byte(), ByVal algorithm As String) As String
        If input Is Nothing Then
            Throw New ArgumentNullException("input")
        End If

        Using alg As HashAlgorithm = HashAlgorithm.Create(algorithm)
            If alg IsNot Nothing Then
                Dim hashData As Byte() = alg.ComputeHash(input)
                Return BinaryToHex(hashData)
            Else
                Throw New InvalidOperationException([String].Format(CultureInfo.InvariantCulture, "Algorithm not supported: {0}", algorithm))
            End If
        End Using
    End Function

    '[SuppressMessage("Microsoft.Naming", "CA1709:IdentifiersShouldBeCasedCorrectly", MessageId = "SHA", Justification = "Consistent with the Framework, which uses SHA")]
    Public Shared Function SHA1(ByVal input As String) As String
        Return Hash(input, "sha1")
    End Function

    '[SuppressMessage("Microsoft.Naming", "CA1709:IdentifiersShouldBeCasedCorrectly", MessageId = "SHA", Justification = "Consistent with the Framework, which uses SHA")]
    Public Shared Function SHA256(ByVal input As String) As String
        Return Hash(input, "sha256")
    End Function

    ' =======================
    '         * HASHED PASSWORD FORMATS
    '         * =======================
    '         * 
    '         * Version 0:
    '         * PBKDF2 with HMAC-SHA1, 128-bit salt, 256-bit subkey, 1000 iterations.
    '         * (See also: SDL crypto guidelines v5.1, Part III)
    '         * Format: { 0x00, salt, subkey }
    '         


    Public Shared Function HashPassword(ByVal password As String) As String
        If password Is Nothing Then
            Throw New ArgumentNullException("password")
        End If

        ' Produce a version 0 (see comment above) password hash.
        Dim salt As Byte()
        Dim subkey As Byte()
        Dim deriveBytes = New Rfc2898DeriveBytes(password, SaltSize, PBKDF2IterCount)

        salt = deriveBytes.Salt
        subkey = deriveBytes.GetBytes(PBKDF2SubkeyLength)


        Dim outputBytes As Byte() = New Byte(1 + SaltSize + (PBKDF2SubkeyLength - 1)) {}
        Buffer.BlockCopy(salt, 0, outputBytes, 1, SaltSize)
        Buffer.BlockCopy(subkey, 0, outputBytes, 1 + SaltSize, PBKDF2SubkeyLength)
        Return Convert.ToBase64String(outputBytes)
    End Function

    ' hashedPassword must be of the format of HashWithPassword (salt + Hash(salt+input)
    Public Shared Function VerifyHashedPassword(ByVal hashedPassword As String, ByVal password As String) As Boolean
        If hashedPassword Is Nothing Then
            Throw New ArgumentNullException("hashedPassword")
        End If
        If password Is Nothing Then
            Throw New ArgumentNullException("password")
        End If

        Dim hashedPasswordBytes As Byte() = Convert.FromBase64String(hashedPassword)

        ' Verify a version 0 (see comment above) password hash.

        If hashedPasswordBytes.Length <> (1 + SaltSize + PBKDF2SubkeyLength) OrElse hashedPasswordBytes(0) <> &H0 Then
            ' Wrong length or version header.
            Return False
        End If

        Dim salt As Byte() = New Byte(SaltSize - 1) {}
        Buffer.BlockCopy(hashedPasswordBytes, 1, salt, 0, SaltSize)
        Dim storedSubkey As Byte() = New Byte(PBKDF2SubkeyLength - 1) {}
        Buffer.BlockCopy(hashedPasswordBytes, 1 + SaltSize, storedSubkey, 0, PBKDF2SubkeyLength)

        Dim generatedSubkey As Byte()
        Dim deriveBytes = New Rfc2898DeriveBytes(password, salt, PBKDF2IterCount)

        generatedSubkey = deriveBytes.GetBytes(PBKDF2SubkeyLength)

        Return ByteArraysEqual(storedSubkey, generatedSubkey)
    End Function

    Friend Shared Function BinaryToHex(ByVal data As Byte()) As String
        Dim hex As Char() = New Char(data.Length * 2 - 1) {}

        For iter As Integer = 0 To data.Length - 1
            Dim hexChar As Byte = CByte(data(iter) >> 4)
            hex(iter * 2) = CChar(ChrW(If(hexChar > 9, hexChar + &H37, hexChar + &H30)))
            hexChar = CByte(data(iter) And &HF)
            hex((iter * 2) + 1) = CChar(ChrW(If(hexChar > 9, hexChar + &H37, hexChar + &H30)))
        Next
        Return New String(hex)
    End Function

    ' Compares two byte arrays for equality. The method is specifically written so that the loop is not optimized.
    '[MethodImpl(MethodImplOptions.NoOptimization)]
    Private Shared Function ByteArraysEqual(ByVal a As Byte(), ByVal b As Byte()) As Boolean
        If ReferenceEquals(a, b) Then
            Return True
        End If

        If a Is Nothing OrElse b Is Nothing OrElse a.Length <> b.Length Then
            Return False
        End If

        Dim areSame As Boolean = True
        For i As Integer = 0 To a.Length - 1
            areSame = areSame And (a(i) = b(i))
        Next
        Return areSame
    End Function

    Public Shared Function GenerateToken() As String
        Dim prng = New RNGCryptoServiceProvider()
        Return GenerateToken(prng)
    End Function

    Friend Shared Function GenerateToken(ByVal generator As RandomNumberGenerator) As String
        Dim tokenBytes As Byte() = New Byte(15) {}
        generator.GetBytes(tokenBytes)
        Return HttpServerUtility.UrlTokenEncode(tokenBytes)
    End Function
    Private Const Keysize As Integer = 256
    Private Const DerivationIterations As Integer = 1000

    Public Shared Function EDEncrypt(ByVal plainText As String, ByVal passPhrase As String) As String
        Dim saltStringBytes = Generate256BitsOfRandomEntropy()
        Dim ivStringBytes = Generate256BitsOfRandomEntropy()
        Dim plainTextBytes = Encoding.UTF8.GetBytes(plainText)

        Using password = New Rfc2898DeriveBytes(passPhrase, saltStringBytes, DerivationIterations)
            Dim keyBytes = password.GetBytes(Keysize / 8)

            Using symmetricKey = New RijndaelManaged()
                symmetricKey.BlockSize = 256
                symmetricKey.Mode = CipherMode.CBC
                symmetricKey.Padding = PaddingMode.PKCS7

                Using encryptor = symmetricKey.CreateEncryptor(keyBytes, ivStringBytes)

                    Using memoryStream = New IO.MemoryStream()

                        Using cryptoStream = New CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write)
                            cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length)
                            cryptoStream.FlushFinalBlock()
                            Dim cipherTextBytes = saltStringBytes
                            cipherTextBytes = cipherTextBytes.Concat(ivStringBytes).ToArray()
                            cipherTextBytes = cipherTextBytes.Concat(memoryStream.ToArray()).ToArray()
                            memoryStream.Close()
                            cryptoStream.Close()
                            Return Convert.ToBase64String(cipherTextBytes)
                        End Using
                    End Using
                End Using
            End Using
        End Using
    End Function

    Public Shared Function EDDecrypt(ByVal cipherText As String, ByVal passPhrase As String) As String
        cipherText = cipherText.Replace(" ", "+")
        Dim cipherTextBytesWithSaltAndIv = Convert.FromBase64String(cipherText)
        Dim saltStringBytes = cipherTextBytesWithSaltAndIv.Take(Keysize / 8).ToArray()
        Dim ivStringBytes = cipherTextBytesWithSaltAndIv.Skip(Keysize / 8).Take(Keysize / 8).ToArray()
        Dim cipherTextBytes = cipherTextBytesWithSaltAndIv.Skip((Keysize / 8) * 2).Take(cipherTextBytesWithSaltAndIv.Length - ((Keysize / 8) * 2)).ToArray()

        Using password = New Rfc2898DeriveBytes(passPhrase, saltStringBytes, DerivationIterations)
            Dim keyBytes = password.GetBytes(Keysize / 8)

            Using symmetricKey = New RijndaelManaged()
                symmetricKey.BlockSize = 256
                symmetricKey.Mode = CipherMode.CBC
                symmetricKey.Padding = PaddingMode.PKCS7

                Using decryptor = symmetricKey.CreateDecryptor(keyBytes, ivStringBytes)

                    Using memoryStream = New IO.MemoryStream(cipherTextBytes)

                        Using cryptoStream = New CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read)
                            Dim plainTextBytes = New Byte(cipherTextBytes.Length - 1) {}
                            Dim decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length)
                            memoryStream.Close()
                            cryptoStream.Close()
                            Return Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount)
                        End Using
                    End Using
                End Using
            End Using
        End Using
    End Function

    Public Shared Function Generate256BitsOfRandomEntropy() As Byte()
        Dim randomBytes = New Byte(31) {}

        Using rngCsp = New RNGCryptoServiceProvider()
            rngCsp.GetBytes(randomBytes)
        End Using

        Return randomBytes
    End Function
End Class

