import Instrument from '../entities/instrument';
import databaseManager from './database_manager';

export const instrumentTableTitle = 'Instrument';

const createTableIfNotExists = async () => {
  const script = `CREATE TABLE IF NOT EXISTS ${instrumentTableTitle} (
    figi TEXT PRIMARY KEY, 
    ticker TEXT NOT NULL, 
    title TEXT NOT NULL,
    lot INT NOT NULL,
    currency TEXT NOT NULL,
    instrumentType TEXT NOT NULL
  )`;

  return await databaseManager.runScript(script);
};

const add = async (instrument: Instrument) => {
  const script = `INSERT INTO ${instrumentTableTitle} 
  (figi, ticker, title, lot, currency, instrumentType) 
  VALUES ($figi, $ticker, $title, $lot, $currency, $instrumentType)`;

  const { figi, ticker, title, lot, currency, instrumentType } = instrument;

  const params = {
    $figi: figi,
    $ticker: ticker,
    $title: title,
    $lot: lot,
    $currency: currency,
    $instrumentType: instrumentType,
  };

  return await databaseManager.runScript(script, params);
};

const addSeveral = async (instruments: Instrument[]) => {
  const promises = [];
  for (const instrument of instruments) {
    const values = [
      instrument.figi,
      instrument.ticker,
      instrument.title,
      instrument.lot,
      instrument.currency,
      instrument.instrumentType,
    ];
    const script = `INSERT INTO ${instrumentTableTitle} 
    (figi, ticker, title, lot, currency, instrumentType) 
    VALUES (?, ?, ?, ?, ?, ?)`;

    promises.push(databaseManager.runScript(script, values));
  }
  return Promise.all(promises);
};

const edit = async (instrument: Instrument) => {
  const script = `UPDATE ${instrumentTableTitle} 
  SET ticker = $ticker, title = $title, lot = $lot, currency = $currency, instrumentType = $instrumentType
  WHERE figi = $figi`;

  const { figi, ticker, title, lot, currency, instrumentType } = instrument;

  const params = {
    $figi: figi,
    $ticker: ticker,
    $title: title,
    $lot: lot,
    $currency: currency,
    $instrumentType: instrumentType,
  };

  return await databaseManager.runScript(script, params);
};

const get = async (figi: string) => {
  const script = `SELECT * FROM ${instrumentTableTitle} 
  WHERE figi = $figi`;

  const params = {
    $figi: figi,
  };

  return await databaseManager.readFirst<Instrument>(script, params);
};

const getAll = async () => {
  const script = `SELECT * FROM ${instrumentTableTitle}
  ORDER BY 
    title ASC
  `;

  return await databaseManager.readAll<Instrument>(script);
};

const getAllWhereQueryIsExists = async (query: string) => {
  const script = `SELECT * FROM ${instrumentTableTitle} 
  WHERE 
    ticker LIKE $query 
    OR ticker LIKE $queryUppercase
    OR ticker LIKE $queryLowercase
    OR ticker LIKE $queryUpperFirst
    OR title LIKE $query
    OR title LIKE $queryUppercase
    OR title LIKE $queryLowercase
    OR title LIKE $queryUpperFirst
  ORDER BY 
    title ASC
  `;

  const params = {
    $query: `%${query}%`,
    $queryUppercase: `%${query.toUpperCase()}%`,
    $queryLowercase: `%${query.toLowerCase()}%`,
    $queryUpperFirst: `%${
      query[0].toUpperCase() + query.substring(1).toLowerCase()
    }%`,
  };

  return await databaseManager.readAll<Instrument>(script, params);
};

const remove = async (figi: string) => {
  const script = `DELETE FROM ${instrumentTableTitle} 
    WHERE figi = $figi`;

  const params = {
    $figi: figi,
  };

  return await databaseManager.runScript(script, params);
};

const InstrumentTableManager = {
  createTableIfNotExists,
  add,
  addSeveral,
  edit,
  get,
  getAll,
  getAllWhereQueryIsExists,
  remove,
};

export default InstrumentTableManager;
