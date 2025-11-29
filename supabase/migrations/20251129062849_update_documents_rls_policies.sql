/*
  # Update Documents RLS Policies

  Allow public access to documents table since this is a shared tracker application
  without user authentication.
*/

DROP POLICY IF EXISTS "Users can view all documents" ON documents;
DROP POLICY IF EXISTS "Users can insert documents" ON documents;
DROP POLICY IF EXISTS "Users can delete documents" ON documents;

CREATE POLICY "Allow all to view documents"
  ON documents
  FOR SELECT
  USING (true);

CREATE POLICY "Allow all to insert documents"
  ON documents
  FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Allow all to delete documents"
  ON documents
  FOR DELETE
  USING (true);
