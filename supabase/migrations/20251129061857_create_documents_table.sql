/*
  # Create Documents Table for Tracker

  1. New Tables
    - `documents`
      - `id` (uuid, primary key)
      - `tracker_id` (text, references the row ID from Firebase)
      - `sheet_type` (text, identifies which sheet: api, white, credit, auth)
      - `file_name` (text)
      - `file_size` (integer)
      - `file_type` (text)
      - `storage_path` (text, path in Supabase storage)
      - `uploaded_by` (text)
      - `uploaded_at` (timestamptz)
      - `document_type` (text, document category)

  2. Security
    - Enable RLS on `documents` table
    - Add policies for authenticated users to manage their documents
*/

CREATE TABLE IF NOT EXISTS documents (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tracker_id text NOT NULL,
  sheet_type text NOT NULL,
  file_name text NOT NULL,
  file_size integer NOT NULL,
  file_type text NOT NULL,
  storage_path text NOT NULL,
  uploaded_by text NOT NULL,
  uploaded_at timestamptz DEFAULT now(),
  document_type text DEFAULT 'General',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE documents ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view all documents"
  ON documents
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can insert documents"
  ON documents
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Users can delete documents"
  ON documents
  FOR DELETE
  TO authenticated
  USING (true);

CREATE INDEX IF NOT EXISTS idx_documents_tracker_id ON documents(tracker_id);
CREATE INDEX IF NOT EXISTS idx_documents_sheet_type ON documents(sheet_type);
