------------------------------------------------------------------------------
-- |
-- Module:      Database.SQLite.Simple.ToRow
-- Copyright:   (c) 2011 MailRank, Inc.
--              (c) 2011-2012 Leon P Smith
--              (c) 2012-2013 Janne Hellsten
-- License:     BSD3
-- Maintainer:  Janne Hellsten <jjhellst@gmail.com>
-- Portability: portable
--
-- The 'ToRow' typeclass, for rendering a collection of
-- parameters to a SQL query.
--
-- Predefined instances are provided for tuples containing up to ten
-- elements.
--
------------------------------------------------------------------------------

module Database.SQLite.Simple.ToRow
    (
      ToRow(..)
    ) where

import Database.SQLite.Simple.ToField (ToField(..))
import Database.SQLite.Simple.Types (Only(..), (:.)(..))

import Database.SQLite3 (SQLData(..))

-- | A collection type that can be turned into a list of 'SQLData'
-- elements.
class ToRow a where
    toRow :: a -> [SQLData]
    -- ^ 'ToField' a collection of values.

instance ToRow () where
    toRow _ = []

instance (ToField a) => ToRow (Only a) where
    toRow (Only v) = [toField v]

instance (ToField a, ToField b) => ToRow (a,b) where
    toRow (a,b) = [toField a, toField b]

instance (ToField a, ToField b, ToField c) => ToRow (a,b,c) where
    toRow (a,b,c) = [toField a, toField b, toField c]

instance (ToField a, ToField b, ToField c, ToField d) => ToRow (a,b,c,d) where
    toRow (a,b,c,d) = [toField a, toField b, toField c, toField d]

instance (ToField a, ToField b, ToField c, ToField d, ToField e)
    => ToRow (a,b,c,d,e) where
    toRow (a,b,c,d,e) =
        [toField a, toField b, toField c, toField d, toField e]

instance (ToField a, ToField b, ToField c, ToField d, ToField e, ToField f)
    => ToRow (a,b,c,d,e,f) where
    toRow (a,b,c,d,e,f) =
        [toField a, toField b, toField c, toField d, toField e, toField f]

instance (ToField a, ToField b, ToField c, ToField d, ToField e, ToField f,
          ToField g)
    => ToRow (a,b,c,d,e,f,g) where
    toRow (a,b,c,d,e,f,g) =
        [toField a, toField b, toField c, toField d, toField e, toField f,
         toField g]

instance (ToField a, ToField b, ToField c, ToField d, ToField e, ToField f,
          ToField g, ToField h)
    => ToRow (a,b,c,d,e,f,g,h) where
    toRow (a,b,c,d,e,f,g,h) =
        [toField a, toField b, toField c, toField d, toField e, toField f,
         toField g, toField h]

instance (ToField a, ToField b, ToField c, ToField d, ToField e, ToField f,
          ToField g, ToField h, ToField i)
    => ToRow (a,b,c,d,e,f,g,h,i) where
    toRow (a,b,c,d,e,f,g,h,i) =
        [toField a, toField b, toField c, toField d, toField e, toField f,
         toField g, toField h, toField i]

instance (ToField a, ToField b, ToField c, ToField d, ToField e, ToField f,
          ToField g, ToField h, ToField i, ToField j)
    => ToRow (a,b,c,d,e,f,g,h,i,j) where
    toRow (a,b,c,d,e,f,g,h,i,j) =
        [toField a, toField b, toField c, toField d, toField e, toField f,
         toField g, toField h, toField i, toField j]

instance (ToField a) => ToRow [a] where
    toRow = map toField

instance (ToRow a, ToRow b) => ToRow (a :. b) where
    toRow (a :. b) = toRow a ++ toRow b
