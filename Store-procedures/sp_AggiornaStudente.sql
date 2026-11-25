-- =============================================
-- Author:		Beniamino
-- Create date: 2026-11-25
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE sp_AggiornaStudente
	@StudenteId INT,
	@Nome NVARCHAR(50),
	@Cognome NVARCHAR(50),
	@RigheModificate INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE Studenti
	SET Nome = @Nome,
		Cognome = @Cognome
	WHERE StudenteId = @StudenteId

	SET @RigheModificate = @@ROWCOUNT;
END
GO

